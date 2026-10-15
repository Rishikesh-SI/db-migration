-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: tmm
-- Object: ix_mum_author_action_aatid
-- Type: INDEX

-- Name: ix_mum_author_action_aatid; Type: INDEX; Schema: tmm; Owner: -
--

CREATE INDEX ix_mum_author_action_aatid ON tmm.tmm_author_action USING btree (asset_id, asset_type_id);


--
