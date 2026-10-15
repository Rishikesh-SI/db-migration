-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labkxp1
-- Object: ix_kxp_asset_list_permid
-- Type: INDEX

-- Name: ix_kxp_asset_list_permid; Type: INDEX; Schema: labkxp1; Owner: -
--

CREATE INDEX ix_kxp_asset_list_permid ON labkxp1.labkxp_asset_list USING btree (primary_entity_role_map_id);


--
