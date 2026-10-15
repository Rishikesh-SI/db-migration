-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: kxp
-- Object: ix_kxp_asset_list_permid
-- Type: INDEX

-- Name: ix_kxp_asset_list_permid; Type: INDEX; Schema: kxp; Owner: -
--

CREATE INDEX ix_kxp_asset_list_permid ON kxp.kxp_asset_list USING btree (primary_entity_role_map_id);


--
