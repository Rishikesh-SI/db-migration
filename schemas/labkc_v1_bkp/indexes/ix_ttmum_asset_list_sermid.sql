-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labkc_v1_bkp
-- Object: ix_ttmum_asset_list_sermid
-- Type: INDEX

-- Name: ix_ttmum_asset_list_sermid; Type: INDEX; Schema: labkc_v1_bkp; Owner: -
--

CREATE INDEX ix_ttmum_asset_list_sermid ON labkc_v1_bkp.labkc_v1_asset_list USING btree (secondary_entity_role_map_id);


--
