-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labdd_v1
-- Object: ix_author_action_aatid
-- Type: INDEX

-- Name: ix_author_action_aatid; Type: INDEX; Schema: labdd_v1; Owner: -
--

CREATE INDEX ix_author_action_aatid ON labdd_v1.labdd_v1_author_action USING btree (asset_type_id, asset_id);


--
