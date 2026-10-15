-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmao_bkp
-- Object: ix_author_action_aatid
-- Type: INDEX

-- Name: ix_author_action_aatid; Type: INDEX; Schema: labmao_bkp; Owner: -
--

CREATE INDEX ix_author_action_aatid ON labmao_bkp.labmao_author_action USING btree (asset_type_id, asset_id);


--
