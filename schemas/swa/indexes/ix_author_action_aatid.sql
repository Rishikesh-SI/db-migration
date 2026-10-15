-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: swa
-- Object: ix_author_action_aatid
-- Type: INDEX

-- Name: ix_author_action_aatid; Type: INDEX; Schema: swa; Owner: -
--

CREATE INDEX ix_author_action_aatid ON swa.swa_author_action USING btree (asset_id, asset_type_id);


--
