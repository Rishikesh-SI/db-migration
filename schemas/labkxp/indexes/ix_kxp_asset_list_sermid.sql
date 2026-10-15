-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labkxp
-- Object: ix_kxp_asset_list_sermid
-- Type: INDEX

-- Name: ix_kxp_asset_list_sermid; Type: INDEX; Schema: labkxp; Owner: -
--

CREATE INDEX ix_kxp_asset_list_sermid ON labkxp.labkxp_asset_list USING btree (secondary_entity_role_map_id);


--
