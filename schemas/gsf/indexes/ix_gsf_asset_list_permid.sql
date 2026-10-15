-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: gsf
-- Object: ix_gsf_asset_list_permid
-- Type: INDEX

-- Name: ix_gsf_asset_list_permid; Type: INDEX; Schema: gsf; Owner: -
--

CREATE INDEX ix_gsf_asset_list_permid ON gsf.gsf_asset_list USING btree (primary_entity_role_map_id);


--
