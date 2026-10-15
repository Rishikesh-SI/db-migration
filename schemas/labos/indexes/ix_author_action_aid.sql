-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labos
-- Object: ix_author_action_aid
-- Type: INDEX

-- Name: ix_author_action_aid; Type: INDEX; Schema: labos; Owner: -
--

CREATE INDEX ix_author_action_aid ON labos.labos_author_action USING btree (author_id);


--
