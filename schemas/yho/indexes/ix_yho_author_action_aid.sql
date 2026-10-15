-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: yho
-- Object: ix_yho_author_action_aid
-- Type: INDEX

-- Name: ix_yho_author_action_aid; Type: INDEX; Schema: yho; Owner: -
--

CREATE INDEX ix_yho_author_action_aid ON yho.yho_author_action USING btree (author_id);


--
