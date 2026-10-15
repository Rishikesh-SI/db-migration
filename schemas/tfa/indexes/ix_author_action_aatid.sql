-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: tfa
-- Object: ix_author_action_aatid
-- Type: INDEX

-- Name: ix_author_action_aatid; Type: INDEX; Schema: tfa; Owner: -
--

CREATE INDEX ix_author_action_aatid ON tfa.tfa_author_action USING btree (asset_id, asset_type_id);


--
