-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labgt_02042024
-- Object: ix_author_action_aid
-- Type: INDEX

-- Name: ix_author_action_aid; Type: INDEX; Schema: labgt_02042024; Owner: -
--

CREATE INDEX ix_author_action_aid ON labgt_02042024.labgt_author_action USING btree (author_id);


--
