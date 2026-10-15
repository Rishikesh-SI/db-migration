-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: cfc
-- Object: ix_cfc_asset_list_sermid
-- Type: INDEX

-- Name: ix_cfc_asset_list_sermid; Type: INDEX; Schema: cfc; Owner: -
--

CREATE INDEX ix_cfc_asset_list_sermid ON cfc.cfc_asset_list USING btree (secondary_entity_role_map_id);


--
