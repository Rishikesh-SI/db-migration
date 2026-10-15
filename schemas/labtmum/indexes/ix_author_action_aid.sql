-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labtmum
-- Object: ix_author_action_aid
-- Type: INDEX

-- Name: ix_author_action_aid; Type: INDEX; Schema: labtmum; Owner: -
--

CREATE INDEX ix_author_action_aid ON labtmum.labtmum_author_action USING btree (author_id);


--
