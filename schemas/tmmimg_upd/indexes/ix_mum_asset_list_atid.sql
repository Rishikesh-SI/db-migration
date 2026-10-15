-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: tmmimg_upd
-- Object: ix_mum_asset_list_atid
-- Type: INDEX

-- Name: ix_mum_asset_list_atid; Type: INDEX; Schema: tmmimg_upd; Owner: -
--

CREATE INDEX ix_mum_asset_list_atid ON tmmimg_upd.tmmimg_upd_asset_list USING btree (asset_type_id);


--
