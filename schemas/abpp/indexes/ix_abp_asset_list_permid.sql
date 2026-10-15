-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: abpp
-- Object: ix_abp_asset_list_permid
-- Type: INDEX

-- Name: ix_abp_asset_list_permid; Type: INDEX; Schema: abpp; Owner: -
--

CREATE INDEX ix_abp_asset_list_permid ON abpp.abp_asset_list USING btree (primary_entity_role_map_id);


--
