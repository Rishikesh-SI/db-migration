-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: rfg
-- Object: ix_author_action_aatid
-- Type: INDEX

-- Name: ix_author_action_aatid; Type: INDEX; Schema: rfg; Owner: -
--

CREATE INDEX ix_author_action_aatid ON rfg.rfg_author_action USING btree (asset_id, asset_type_id);


--
