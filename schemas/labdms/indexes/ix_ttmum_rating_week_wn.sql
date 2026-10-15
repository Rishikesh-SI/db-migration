-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labdms
-- Object: ix_ttmum_rating_week_wn
-- Type: INDEX

-- Name: ix_ttmum_rating_week_wn; Type: INDEX; Schema: labdms; Owner: -
--

CREATE INDEX ix_ttmum_rating_week_wn ON labdms.labdms_rating_week USING btree (week_number);


--
