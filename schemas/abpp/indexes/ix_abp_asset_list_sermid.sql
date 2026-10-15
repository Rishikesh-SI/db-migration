-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: abpp
-- Object: ix_abp_asset_list_sermid
-- Type: INDEX

-- Name: ix_abp_asset_list_sermid; Type: INDEX; Schema: abpp; Owner: -
--

CREATE INDEX ix_abp_asset_list_sermid ON abpp.abp_asset_list USING btree (secondary_entity_role_map_id);


--
