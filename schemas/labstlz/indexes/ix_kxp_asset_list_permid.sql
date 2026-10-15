-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labstlz
-- Object: ix_kxp_asset_list_permid
-- Type: INDEX

-- Name: ix_kxp_asset_list_permid; Type: INDEX; Schema: labstlz; Owner: -
--

CREATE INDEX ix_kxp_asset_list_permid ON labstlz.labstlz_asset_list USING btree (primary_entity_role_map_id);


--
