-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: ttgl
-- Object: ix_ttgl_author_action_aatid
-- Type: INDEX

-- Name: ix_ttgl_author_action_aatid; Type: INDEX; Schema: ttgl; Owner: -
--

CREATE INDEX ix_ttgl_author_action_aatid ON ttgl.ttgl_author_action USING btree (asset_id, asset_type_id);


--
