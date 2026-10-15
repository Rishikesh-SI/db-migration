-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labgt
-- Object: index_verificationkey
-- Type: INDEX

-- Name: index_verificationkey; Type: INDEX; Schema: labgt; Owner: -
--

CREATE INDEX index_verificationkey ON labgt.labgt_web_user USING btree (verification_key);


--
