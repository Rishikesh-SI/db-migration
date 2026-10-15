-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: fanxp_wf
-- Object: labwf_rating_week_week_of_year_idx
-- Type: INDEX

-- Name: labwf_rating_week_week_of_year_idx; Type: INDEX; Schema: fanxp_wf; Owner: -
--

CREATE INDEX labwf_rating_week_week_of_year_idx ON fanxp_wf.labwf_rating_week USING btree (week_of_year);


--
