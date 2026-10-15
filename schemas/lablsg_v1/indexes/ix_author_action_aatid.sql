-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: lablsg_v1
-- Object: ix_author_action_aatid
-- Type: INDEX

-- Name: ix_author_action_aatid; Type: INDEX; Schema: lablsg_v1; Owner: -
--

CREATE INDEX ix_author_action_aatid ON lablsg_v1.lablsg_v1_author_action USING btree (asset_type_id, asset_id);


--
