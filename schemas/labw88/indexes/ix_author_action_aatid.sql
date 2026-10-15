-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labw88
-- Object: ix_author_action_aatid
-- Type: INDEX

-- Name: ix_author_action_aatid; Type: INDEX; Schema: labw88; Owner: -
--

CREATE INDEX ix_author_action_aatid ON labw88.labw88_author_action USING btree (asset_type_id, asset_id);


--
