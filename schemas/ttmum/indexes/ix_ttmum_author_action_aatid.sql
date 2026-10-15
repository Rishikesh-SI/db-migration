-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: ttmum
-- Object: ix_ttmum_author_action_aatid
-- Type: INDEX

-- Name: ix_ttmum_author_action_aatid; Type: INDEX; Schema: ttmum; Owner: -
--

CREATE INDEX ix_ttmum_author_action_aatid ON ttmum.ttmum_author_action USING btree (asset_id, asset_type_id);


--
