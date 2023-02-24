/* eslint-disable no-unused-vars */
import { ethers } from 'ethers';

const CLOUDFLARE_ENDPOINT = 'https://rpc.ankr.com/polygon_mumbai';
const MAIN_ENDPOINT = 'https://rpc.ankr.com/polygon_mumbai';
const ALTERNATE_ENDPOINT = 'https://rpc.ankr.com/polygon_mumbai';
const UNSECURE_ENDPOINT = 'https://rpc.ankr.com/polygon_mumbai';
const QUICKNODE_ENDPOINT = "https://rpc.ankr.com/polygon_mumbai"

export function createProvider() {
  return new ethers.providers.JsonRpcProvider(QUICKNODE_ENDPOINT || MAIN_ENDPOINT, 80001);
}