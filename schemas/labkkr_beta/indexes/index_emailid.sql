-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labkkr_beta
-- Object: index_emailid
-- Type: INDEX

-- Name: index_emailid; Type: INDEX; Schema: labkkr_beta; Owner: -
--

CREATE INDEX index_emailid ON labkkr_beta.labkkr_web_user_13032023 USING btree (upper_email_id);


--
