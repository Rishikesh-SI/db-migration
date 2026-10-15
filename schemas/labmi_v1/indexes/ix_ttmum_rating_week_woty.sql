-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmi_v1
-- Object: ix_ttmum_rating_week_woty
-- Type: INDEX

-- Name: ix_ttmum_rating_week_woty; Type: INDEX; Schema: labmi_v1; Owner: -
--

CREATE INDEX ix_ttmum_rating_week_woty ON labmi_v1.labmi_v1_rating_week USING btree (week_of_year);


--
