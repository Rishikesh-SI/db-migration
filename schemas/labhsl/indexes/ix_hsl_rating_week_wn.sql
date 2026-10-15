-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labhsl
-- Object: ix_hsl_rating_week_wn
-- Type: INDEX

-- Name: ix_hsl_rating_week_wn; Type: INDEX; Schema: labhsl; Owner: -
--

CREATE INDEX ix_hsl_rating_week_wn ON labhsl.labhsl_rating_week USING btree (week_number);


--
