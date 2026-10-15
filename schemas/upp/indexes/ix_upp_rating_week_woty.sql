-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: upp
-- Object: ix_upp_rating_week_woty
-- Type: INDEX

-- Name: ix_upp_rating_week_woty; Type: INDEX; Schema: upp; Owner: -
--

CREATE INDEX ix_upp_rating_week_woty ON upp.upp_rating_week USING btree (week_of_year);


--
