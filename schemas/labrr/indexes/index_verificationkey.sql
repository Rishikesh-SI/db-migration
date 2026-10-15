-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labrr
-- Object: index_verificationkey
-- Type: INDEX

-- Name: index_verificationkey; Type: INDEX; Schema: labrr; Owner: -
--

CREATE INDEX index_verificationkey ON labrr.labrr_web_user USING btree (verification_key);


--
