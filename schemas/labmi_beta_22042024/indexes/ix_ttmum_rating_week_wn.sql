-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmi_beta_22042024
-- Object: ix_ttmum_rating_week_wn
-- Type: INDEX

-- Name: ix_ttmum_rating_week_wn; Type: INDEX; Schema: labmi_beta_22042024; Owner: -
--

CREATE INDEX ix_ttmum_rating_week_wn ON labmi_beta_22042024.labmi_rating_week USING btree (week_number);


--
