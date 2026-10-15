-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: dd
-- Object: index_verificationkey
-- Type: INDEX

-- Name: index_verificationkey; Type: INDEX; Schema: dd; Owner: -
--

CREATE INDEX index_verificationkey ON dd.dd_web_user USING btree (verification_key);


--
