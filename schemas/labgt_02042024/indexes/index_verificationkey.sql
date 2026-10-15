-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labgt_02042024
-- Object: index_verificationkey
-- Type: INDEX

-- Name: index_verificationkey; Type: INDEX; Schema: labgt_02042024; Owner: -
--

CREATE INDEX index_verificationkey ON labgt_02042024.labgt_web_user USING btree (verification_key);


--
