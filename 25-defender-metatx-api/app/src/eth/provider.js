/* eslint-disable no-unused-vars */
import { ethers } from 'ethers';

const CLOUDFLARE_ENDPOINT = 'https://rpc.ankr.com/polygon_mumbai';
const MAIN_ENDPOINT = 'https://polygon-mainnet.g.alchemy.com/v2/38R9Vnxi-6UPne8ACF4k4radrS8-6UJ1';
const ALTERNATE_ENDPOINT = 'https://rpc.ankr.com/polygon_mumbai';
const UNSECURE_ENDPOINT = 'https://rpc.ankr.com/polygon_mumbai';
const QUICKNODE_ENDPOINT = "https://polygon-mainnet.g.alchemy.com/v2/38R9Vnxi-6UPne8ACF4k4radrS8-6UJ1"

export function createProvider() {
  return new ethers.providers.JsonRpcProvider(QUICKNODE_ENDPOINT || MAIN_ENDPOINT, 137);
}