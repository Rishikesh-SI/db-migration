-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: dd
-- Object: ix_author_action_aatid
-- Type: INDEX

-- Name: ix_author_action_aatid; Type: INDEX; Schema: dd; Owner: -
--

CREATE INDEX ix_author_action_aatid ON dd.dd_author_action USING btree (asset_id, asset_type_id);


--
