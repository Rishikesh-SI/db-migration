-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: pbl
-- Object: gnix_pbl_asset_list_short_desc
-- Type: INDEX

-- Name: gnix_pbl_asset_list_short_desc; Type: INDEX; Schema: pbl; Owner: -
--

CREATE INDEX gnix_pbl_asset_list_short_desc ON pbl.pbl_asset_list USING gin (short_desc public.gin_trgm_ops);


--
