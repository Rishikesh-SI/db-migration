-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labkkr
-- Object: index_emailid
-- Type: INDEX

-- Name: index_emailid; Type: INDEX; Schema: labkkr; Owner: -
--

CREATE INDEX index_emailid ON labkkr.labkkr_web_user_13032023 USING btree (upper_email_id);


--
