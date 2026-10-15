-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: tfa
-- Object: ix_tfa_rating_week_ry
-- Type: INDEX

-- Name: ix_tfa_rating_week_ry; Type: INDEX; Schema: tfa; Owner: -
--

CREATE INDEX ix_tfa_rating_week_ry ON tfa.tfa_rating_week USING btree (rating_year);


--
