-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labstmp
-- Object: ix_author_action_aatid
-- Type: INDEX

-- Name: ix_author_action_aatid; Type: INDEX; Schema: labstmp; Owner: -
--

CREATE INDEX ix_author_action_aatid ON labstmp.labstmp_author_action USING btree (asset_type_id, asset_id);


--
