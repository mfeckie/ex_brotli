extern crate brotli;
use brotli::CompressorReader;
use rustler::{Binary, Encoder, Env, NifResult, OwnedBinary, Term};
use std::io::{Read, Write};

#[rustler::nif]
fn compress<'a>(env: Env<'a>, input: Binary) -> NifResult<Term<'a>> {
    let mut compressor = CompressorReader::new(input.as_slice(), 4096, 11, 22);

    let mut compress_bytes = Vec::new();

    match compressor.read_to_end(&mut compress_bytes) {
        Ok(_) => {
            let mut binary = OwnedBinary::new(compress_bytes.len()).unwrap();
            let _ = binary.as_mut_slice().write_all(&compress_bytes);
            Ok((rustler::types::atom::ok(), binary.release(env)).encode(env))
        }
        Err(_e) => Ok((rustler::types::atom::error(), "error compressing payload").encode(env)),
    }
}

#[rustler::nif]
fn decompress<'a>(env: Env<'a>, input: Binary) -> NifResult<Term<'a>> {
    let mut decompressor = brotli::Decompressor::new(input.as_slice(), 4096);

    let mut decompress_bytes = Vec::new();

    match decompressor.read_to_end(&mut decompress_bytes) {
        Ok(_) => {
            let mut binary = OwnedBinary::new(decompress_bytes.len()).unwrap();
            let _ = binary.as_mut_slice().write_all(&decompress_bytes);
            Ok((rustler::types::atom::ok(), binary.release(env)).encode(env))
        }
        Err(_e) => Ok((rustler::types::atom::error(), "error decompressing payload").encode(env)),
    }
}

rustler::init!("Elixir.ExBrotli");
