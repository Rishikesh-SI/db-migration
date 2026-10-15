-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: isl
-- Object: ix_isl_author_action_aatid
-- Type: INDEX

-- Name: ix_isl_author_action_aatid; Type: INDEX; Schema: isl; Owner: -
--

CREATE INDEX ix_isl_author_action_aatid ON isl.isl_author_action USING btree (asset_id, asset_type_id);


--
