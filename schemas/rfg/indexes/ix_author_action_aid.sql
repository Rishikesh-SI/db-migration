-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: rfg
-- Object: ix_author_action_aid
-- Type: INDEX

-- Name: ix_author_action_aid; Type: INDEX; Schema: rfg; Owner: -
--

CREATE INDEX ix_author_action_aid ON rfg.rfg_author_action USING btree (author_id);


--
