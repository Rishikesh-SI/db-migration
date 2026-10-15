-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labpc
-- Object: ix_author_action_aid
-- Type: INDEX

-- Name: ix_author_action_aid; Type: INDEX; Schema: labpc; Owner: -
--

CREATE INDEX ix_author_action_aid ON labpc.labpc_author_action USING btree (author_id);


--
