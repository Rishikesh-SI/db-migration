-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labkkr_beta
-- Object: index_verificationkey
-- Type: INDEX

-- Name: index_verificationkey; Type: INDEX; Schema: labkkr_beta; Owner: -
--

CREATE INDEX index_verificationkey ON labkkr_beta.labkkr_web_user_13032023 USING btree (verification_key);


--
