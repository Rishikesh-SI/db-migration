-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labilt
-- Object: ix_author_action_aatid
-- Type: INDEX

-- Name: ix_author_action_aatid; Type: INDEX; Schema: labilt; Owner: -
--

CREATE INDEX ix_author_action_aatid ON labilt.labilt_author_action USING btree (asset_type_id, asset_id);


--
