-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: tmmimg_upd
-- Object: ix_mum_asset_list_permid
-- Type: INDEX

-- Name: ix_mum_asset_list_permid; Type: INDEX; Schema: tmmimg_upd; Owner: -
--

CREATE INDEX ix_mum_asset_list_permid ON tmmimg_upd.tmmimg_upd_asset_list USING btree (primary_entity_role_map_id);


--
