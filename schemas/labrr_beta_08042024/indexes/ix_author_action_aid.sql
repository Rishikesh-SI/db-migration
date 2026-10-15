-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labrr_beta_08042024
-- Object: ix_author_action_aid
-- Type: INDEX

-- Name: ix_author_action_aid; Type: INDEX; Schema: labrr_beta_08042024; Owner: -
--

CREATE INDEX ix_author_action_aid ON labrr_beta_08042024.labrr_author_action USING btree (author_id);


--
