-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: cli_stp_v1
-- Object: ix_author_action_aatid
-- Type: INDEX

-- Name: ix_author_action_aatid; Type: INDEX; Schema: cli_stp_v1; Owner: -
--

CREATE INDEX ix_author_action_aatid ON cli_stp_v1.cli_stp_v1_author_action USING btree (asset_type_id, asset_id);


--
