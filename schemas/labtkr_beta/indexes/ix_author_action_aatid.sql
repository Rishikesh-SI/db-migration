-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labtkr_beta
-- Object: ix_author_action_aatid
-- Type: INDEX

-- Name: ix_author_action_aatid; Type: INDEX; Schema: labtkr_beta; Owner: -
--

CREATE INDEX ix_author_action_aatid ON labtkr_beta.labtkr_author_action USING btree (asset_type_id, asset_id);


--
