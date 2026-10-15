-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labgt01_v1
-- Object: index_verificationkey
-- Type: INDEX

-- Name: index_verificationkey; Type: INDEX; Schema: labgt01_v1; Owner: -
--

CREATE INDEX index_verificationkey ON labgt01_v1.labgt01_v1_web_user USING btree (verification_key);


--
