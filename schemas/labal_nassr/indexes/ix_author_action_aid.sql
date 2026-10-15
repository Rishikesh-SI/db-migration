-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labal_nassr
-- Object: ix_author_action_aid
-- Type: INDEX

-- Name: ix_author_action_aid; Type: INDEX; Schema: labal_nassr; Owner: -
--

CREATE INDEX ix_author_action_aid ON labal_nassr.labal_nassr_author_action USING btree (author_id);


--
