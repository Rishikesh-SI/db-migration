-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: lablsg
-- Object: ix_ttmum_asset_list_aid
-- Type: INDEX

-- Name: ix_ttmum_asset_list_aid; Type: INDEX; Schema: lablsg; Owner: -
--

CREATE INDEX ix_ttmum_asset_list_aid ON lablsg.lablsg_asset_list USING btree (asset_id);


--
