-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labrlp
-- Object: ix_ttmum_asset_list_sermid
-- Type: INDEX

-- Name: ix_ttmum_asset_list_sermid; Type: INDEX; Schema: labrlp; Owner: -
--

CREATE INDEX ix_ttmum_asset_list_sermid ON labrlp.labrlp_asset_list USING btree (secondary_entity_role_map_id);


--
